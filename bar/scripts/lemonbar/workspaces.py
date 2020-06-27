#!/usr/bin/env python

from typing import NamedTuple
import io
import json
import sys
import subprocess

SUBSCRIBE_COMMAND = ["bspc", "subscribe", "desktop"]
DUMP_STATE_COMMAND = ["bspc", "wm", "--dump-state"]
BATTERY_COMMAND=["acpi", "|", "awk","'{print $4}'", "|", "sed ","'s/,//'"]
MONITOR_SEPARATOR = " | "
DESKTOP_SEPARATOR = " "

class Monitor:
    def __init__(self, state):
        self.desktops = [
            Desktop(d, state["focusedDesktopId"])
            for d in state["desktops"]]

    def __str__(self) -> str:
        return DESKTOP_SEPARATOR.join(
            filter(lambda s: s,
                map(str, self.desktops)))

class Desktop:
    def __init__(self, state, focused_id):
        self.name = state["name"]
        self.focused = state["id"] == focused_id
        self.occupied = state["root"] is not None

    def __str__(self) -> str:
        if self.focused:
            return " %{F#ffffff}"f"{self.name}"
            # return " %{F#ffffff}%{B#000433}"f"{self.name}"
        elif self.occupied:
            return " %{F#B3B0AB}"f"{self.name}"
            # return " %{F#827098}%{B#000433}"f"{self.name}"
        return ""

def print_workspaces() -> None:
    state = json.loads(subprocess.check_output(DUMP_STATE_COMMAND))
    monitors = [
        Monitor(m)
        for m in state["monitors"]]
    print(MONITOR_SEPARATOR.join(map(str, monitors)))
    sys.stdout.flush()
# def print_battery() -> None:
    # battery = subprocess.run([]) 
    # battery = subprocess.run(["acpi","|","awk","'{print","$4}'","|","sed","'s/,//'"]) 
    # print (battery)

# acpi | awk '{print $4}' | sed 's/,//'


def loop(callback) -> None:
    subscribe_command = subprocess.Popen(
        SUBSCRIBE_COMMAND, stdout=subprocess.PIPE)
    for _ in io.TextIOWrapper(subscribe_command.stdout, encoding="utf-8"):
        callback()

if __name__ == "__main__":
    print_workspaces()
    # print_battery() 
    loop(print_workspaces)
    # loop(print_battery)


