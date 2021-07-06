<?php

return [
    // Host to listen on (defaults to 127.0.0.1)
    'host' => '0.0.0.0',

    // Port for web interface to listen on (defaults to 8100)
    'port' => 8100,
    
    // Verbose logging
    'verbose' => true,
    
    // Tasks available 
    'tasks' => [
        [
            'name' => "Nginx",
            'retries' => -1,
            'autostart' => true,
            'cmd' => 'nginx -g "daemon off; error_log /dev/stdout info;"'
        ],
        [
            'name' => "PHP-FPM",
            'retries' => -1,
            'autostart' => true,
            'cmd' => 'php-fpm8.0 -F'
        ],
    ]
];