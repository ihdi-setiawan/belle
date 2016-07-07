<?php

error_reporting(E_ALL);

use Phalcon\Mvc\Application;

try {

	/**
	 * Read the configuration
	 */
	$config = include __DIR__ . "/../app/config/config.php";

	/**
	 * Read auto-loader
	 */
	include __DIR__ . "/../app/config/loader.php";

	/**
	 * Read services
	 */
	include __DIR__ . "/../app/config/services.php";

	/**
	 * Handle the request
	 */
	$application = new Application($di);

	echo $application->handle()->getContent();

} catch(\PDOException $e) {
	if ($config->application['debug']) {
		echo 'File:' . $e->getFile() . ' line: ' . $e->getLine() . "<br/> message: " .$e->getMessage();
		echo "<br/>" . $e->getTraceAsString();
	} else {
		$message = "File:" . $e->getFile() . ' line: ' . $e->getLine() . "\r\nMessage: " .$e->getMessage();
		$fileName = $config->application['logDir'].'/db_api_error-'.date('Y-m-d').'.log';
		file_put_contents($fileName, $message.PHP_EOL , FILE_APPEND);
		header('Content-Type: application/json');
		die(json_encode(array('code' => '204', 'message' => 'Internal Server error')));
	}
} catch (\Exception $e) {
	if ($config->application['debug']) {
		echo 'File:' . $e->getFile() . ' line: ' . $e->getLine() . "<br/> message: " .$e->getMessage();
		echo "<br/>" . $e->getTraceAsString();
	} else {
		$message = "File:" . $e->getFile() . ' line: ' . $e->getLine() . "\r\nMessage: " .$e->getMessage();
		$fileName = $config->application['logDir'].'/global_api_error-'.date('Y-m-d').'.log';
		file_put_contents($fileName, $message.PHP_EOL , FILE_APPEND);
		header('Content-Type: application/json');
		die(json_encode(array('code' => '204', 'message' => 'Internal error')));
	}
}
