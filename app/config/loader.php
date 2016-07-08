<?php

$loader = new \Phalcon\Loader();

/**
 * We're a registering a set of directories taken from the configuration file
 */
$loader->registerNamespaces(
        array(
        	'OAuth2' => __DIR__.'/../plugins/OAuth2',
            'App\Controllers' => __DIR__ . '/../controllers/',
            'App\Library' => __DIR__ . '/../library/',
            'App\Models' => __DIR__ . '/../models/',
            'App\Controllers\Admin' => __DIR__ . '/../controllers/admin'
        )
)->register();

// Use composer autoloader to load vendor classes
require_once __DIR__ . '/../../vendor/autoload.php';

function pr($a, $stop = 0)
{
    echo "<pre>";
    if (is_object($a)) {
        $a = (array) $a;
    }
    if (is_array($a)) {
        print_r($a);
    } else {
        echo $a;
    }
    if ($stop) exit;
}