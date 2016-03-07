import sys, os, string, time, readline, rlcompleter, copy

readline.parse_and_bind("C-spc: complete")

h = [None]

class Prompt:
    def __init__(self, str='h[%d] >>> '):
        self.str = str;

    def __str__(self):
        try:
            if _ not in [h[-1], None, h]: h.append(copy.deepcopy(_));
        except NameError:
            pass
        except TypeError:  # weird object.__new__(self) not safe error
            pass
        return self.str % len(h);

    def __radd__(self, other):
        return str(other) + str(self)


if os.environ.get('TERM') in [ 'xterm', 'vt100', 'rxvt-unicode']:
    sys.ps1 = Prompt('\001\033[0:1;31m\002h[%d] >>> \001\033[0m\002')
else:
    sys.ps1 = Prompt()
sys.ps2 = ''

