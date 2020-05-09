import sys, os, string, time, readline, rlcompleter, copy
import itertools, collections

readline.parse_and_bind("C-spc: complete")

history = [None]


class Prompt:
    def __init__(self, str='h[%d] >>> '):
        self.str = str

    def __str__(self):
        try:
            if _ not in [history[-1], None, history]:
                history.append(copy.deepcopy(_))
        except NameError:
            pass
        except TypeError:  # weird object.__new__(self) not safe error
            pass
        try:
            return self.str % len(history)
        except TypeError:  # history was overwritten)
            return 'h[X] >>> '
        except Exception as ex:
            return 'EXCEPTION(%s)' % ex

    def __radd__(self, other):
        return str(other) + str(self)


if os.environ.get('TERM') in ['xterm', 'vt100', 'rxvt-unicode']:
    sys.ps1 = Prompt('\001\033[0:1;31m\002h[%d] >>> \001\033[0m\002')
else:
    sys.ps1 = Prompt()
sys.ps2 = ''
