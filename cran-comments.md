## Notes

This is a corrected version of a recently submitted package for which valgrind
had identified issues because of the use of uninitialized values in the source
code. The remaining issues appear to be  false positives from valgrind.
First, because the output seems to depend on how the same C++ function gets
called by R (some of the examples do not show the issue, but would create the
same objects in the source code), and also because the error messages from
valgrind do not actually point to anywhere in the package source code but
primarily point to libR.so. 

## Test environments

* local OS X install, R 4.0.3
* Windows Server 2008 R2 SP1 (R-Hub, R-devel)
* r-hub check with valgrind

## R CMD check results

0 errors | 0 warnings | 0 note

## Reverse dependencies

There are no reverse dependencies for this package.