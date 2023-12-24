from re import compile as __re_compile
from typing import TypeVar as __TypeVar

_T = __TypeVar('_T', bound=dict)
__sanitizer_pat = __re_compile(r"((?<!\\)(?:\\\\)*)(')")


def sanitize(m: _T) -> _T:
    return {
        k: (
            __sanitizer_pat.sub(r'\g<1>\\\g<2>', v)
            if isinstance(v, str)
            else v
        )
        for k, v in m.items()
    }


if __name__ == '__main__':
    print(sanitize({'name': 'Tony\'; DROP TABLE USERS'}))
