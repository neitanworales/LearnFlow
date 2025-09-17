<?php

function msToTime($ms)
{
    $seconds = floor($ms / 1000);
    $hours = floor($seconds / 3600);
    $minutes = floor(($seconds % 3600) / 60);
    $secs = $seconds % 60;

    return sprintf("%02d:%02d:%02d", $hours, $minutes, $secs);
}

function secondsToHms($seconds) {
    $hours   = floor($seconds / 3600);
    $minutes = floor(($seconds % 3600) / 60);
    $secs    = $seconds % 60;

    return sprintf("%02d:%02d:%02d", $hours, $minutes, $secs);
}

?>