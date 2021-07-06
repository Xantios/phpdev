<?php

print "Hello world! Im running PHP ".PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION." on Docker ".PHP_EOL;
print "xDebug version: ".phpversion('xdebug');

phpinfo();
