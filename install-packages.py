"""
A small script for install
the dependencies packages for build vim8 with python3
support.
"""

from subprocess import call


def install(filename:str) -> None:
  """
  Install the packages
  for the filename passed
  for parameter.
  """

  # to save packages
  packages_list = []

  try:
    with open(filename, 'r') as f:
      lines = f.readlines()

      for line in lines:
        packages_list.append(line)

  except FileNotFoundError:
    print('The filename passed for parameter not is found.')

  for package in packages_list:
   # installing each package
   call(['apk', 'add', '--no-cache', f'{package}']) 


if __name__ == '__main__':

  # edit for other packages
  PACKAGES_FILE = './packages-dep.txt'

  install(PACKAGES_FILE)