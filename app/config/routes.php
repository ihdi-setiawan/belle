<?php

$router = new Phalcon\Mvc\Router(false);

$router->addPost('/auth/(login|register|forgot|logout)', array(
	'namespace' => 'App\Controllers',
	'controller' => 'auth',
	'action' => 1,
));

$router->add('/:controller', array(
	'namespace' => 'App\Controllers',
	'controller' => 1
));

$router->add('/admin/:controller/:action/:params', array(
	'namespace' => 'App\Controllers\Admin',
	'controller' => 1,
	'action' => 2,
	'params' => 3,
));

$router->add('/admin/:controller', array(
	'namespace' => 'App\Controllers\Admin',
	'controller' => 1
));

$router->notFound(
    array(
    	'namespace' => 'App\Controllers',
        'controller' => 'base',
        'action'     => 'notFound404',
    )
);

$router->removeExtraSlashes(true);

return $router;