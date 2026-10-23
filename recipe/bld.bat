%PYTHON% -m pip install . -vv
if errorlevel 1 exit 1

REM aliyunsdkcore vendors an old copy of requests whose bundled certifi
REM returns a hardcoded path to its own frozen CA bundle, ignoring the
REM environment entirely. Point it at the bundle the ca-certificates
REM package provides instead.
set "VENDORED_CACERT=%SP_DIR%\aliyunsdkcore\vendored\requests\packages\certifi\cacert.pem"
del /f "%VENDORED_CACERT%"
if errorlevel 1 exit 1
copy /y "%LIBRARY_PREFIX%\ssl\cacert.pem" "%VENDORED_CACERT%"
if errorlevel 1 exit 1
