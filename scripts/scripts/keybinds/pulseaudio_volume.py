#!/usr/bin/env python

from collections import namedtuple
import re
import subprocess
import textwrap
from typing import Iterator, List


SinkLines = namedtuple('SinkLines', ['index', 'lines'])
SinkVolume = namedtuple('SinkVolume', ['index', 'volume'])

REGEX_SINK = re.compile(r'^\s+(\*\s)?index:\s(?P<index>\d+)$')
REGEX_RUNNING = re.compile(r'\s+state: RUNNING$')
REGEX_VOLUME = re.compile(r'\s+volume:.+?\b(?P<volume>\d+)%.+$')


def read_lines() -> List[str]:
    completed = subprocess.run(['pacmd', 'list-sinks'], stdout=subprocess.PIPE)
    stdout = completed.stdout.decode()
    return stdout.splitlines()


def extract_sinks_lines(lines: List[str]) -> Iterator[SinkLines]:
    sink_lines = None
    for i, line in enumerate(lines):
        m = REGEX_SINK.match(line)
        if m:
            if sink_lines:
                yield sink_lines
            sink_lines = SinkLines(index=m.group('index'), lines=[])
        elif sink_lines:
            sink_lines.lines.append(line)
            if i == len(lines) - 1:
                yield sink_lines


def filter_running_sinks(
        sinks_lines: Iterator[SinkLines]) -> Iterator[SinkLines]:
    for sink_lines in sinks_lines:
        for line in sink_lines.lines:
            if REGEX_RUNNING.match(line):
                yield sink_lines


def extract_sinks_volumes(
        sinks_lines: Iterator[SinkLines]) -> Iterator[SinkVolume]:
    for sink_lines in sinks_lines:
        for line in sink_lines.lines:
            m = REGEX_VOLUME.match(line)
            if m:
                volume = int(m.group('volume'))
                yield SinkVolume(index=sink_lines.index, volume=volume)


def adjust_sinks_volumes(sinks_volumes: Iterator[SinkVolume],
                         volume: int) -> Iterator[SinkVolume]:
    for sink_volume in sinks_volumes:
        new_volume = max(0, min(sink_volume.volume + volume, 100))
        yield SinkVolume(index=sink_volume.index, volume=new_volume)


def write_sinks_volumes(sinks_volumes: Iterator[SinkVolume]):
    for sink_volume in sinks_volumes:
        cmd = 'pactl set-sink-volume {i} {v}%'.format(i=sink_volume.index,
                                                      v=sink_volume.volume)
        print(cmd)
        subprocess.run(cmd, shell=True, check=True)


def toggle_sinks(sinks_lines: Iterator[SinkLines]):
    for sink_lines in sinks_lines:
        cmd = 'pactl set-sink-mute {i} toggle'.format(i=sink_lines.index)
        print(cmd)
        subprocess.run(cmd, shell=True, check=True)


def adjust_volume(volume: int):
    lines = read_lines()
    all_sinks_lines = extract_sinks_lines(lines)
    sinks_lines = filter_running_sinks(all_sinks_lines)
    sinks_volumes = extract_sinks_volumes(sinks_lines)
    adjusted_sinks_volumes = adjust_sinks_volumes(sinks_volumes, volume)
    write_sinks_volumes(adjusted_sinks_volumes)


def toggle_mute():
    lines = read_lines()
    all_sinks_lines = extract_sinks_lines(lines)
    sinks_lines = filter_running_sinks(all_sinks_lines)
    toggle_sinks(sinks_lines)


def main():
    import argparse
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=('Adjust volume or toggle mute of all running PulseAudio '
                     'sinks.'),
        epilog=textwrap.dedent('''\
            examples:

            increase volume by 5% (don't go above 100%)
              pulseaudio_volume.py inc 5

            decrease volume by 10%
              pulseaudio_volume.py dec 10

            toggle mute
              pulseaudio_volume.py toggle
        '''))
    subparsers = parser.add_subparsers(dest='action')
    subparsers.required = True

    parser_inc = subparsers.add_parser('inc', help='increase volume')
    parser_inc.add_argument('perc', type=int, help='increase by PERC percents')

    parser_dec = subparsers.add_parser('dec', help='decrease volume')
    parser_dec.add_argument('perc', type=int, help='decrease by PERC percents')

    subparsers.add_parser('toggle', help='toggle mute')

    args = parser.parse_args()

    if args.action == 'inc':
        adjust_volume(args.perc)
    elif args.action == 'dec':
        adjust_volume(-args.perc)
    elif args.action == 'toggle':
        toggle_mute()


if __name__ == '__main__':
    main()
