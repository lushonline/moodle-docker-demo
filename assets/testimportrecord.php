<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * Prints an instance of mod_externalcontent.
 *
 * @package     mod_externalcontent
 * @copyright   2019-2022 LushOnline
 * @license     http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
use mod_externalcontent\instance;
use mod_externalcontent\importableinstance;
use mod_externalcontent\newinstance;
use mod_externalcontent\importrecord;

require(__DIR__.'/../../config.php');
require_login();

$course1 = new stdClass();
$course1->idnumber = 'test-idnumber3';
$course1->shortname = 'test-shortname3';
$course1->fullname = 'test-fullname3';
$course1->summary = 'test-summary';
$course1->tags = array('test1', 'test2');
$course1->visible = 1;
$course1->thumbnail = 'https://cdn2.percipio.com/public/c/channel/images/saved/001132c1-2c37-11e7-83d1-dba0327abefc.jpg';
$course1->category = 1;

$instance1 = new \stdClass();
$instance1->name = 'test-instance-name';
$instance1->intro = 'test-instance-intro';
$instance1->content = 'test-instance-content';
$instance1->markcompleteexternally = 1;

$importrecord = new importrecord($course1, $instance1);
$instance = importableinstance::get_from_importrecord($importrecord);

echo '<h1>Created from ImportRecord (ImportableInstance)</h1>';
echo '<pre>'.var_dump($instance).'</pre>';

echo '<h1>Created from ImportRecord (ImportableInstance) - messages</h1>';
echo '<pre>'.var_dump($instance->get_messages()).'</pre>';

$newinstance = instance::get_from_cmidnumber($course1->idnumber);

echo '<h1>Retrieve by CM idnumber (Instance)</h1>';
echo '<pre>'.var_dump($newinstance).'</pre>';
echo '<h1>Retrieve by CM idnumber (Instance) - messages</h1>';
echo '<pre>'.var_dump($newinstance->get_messages()).'</pre>';

echo '<h1>Get user (NewInstance)</h1>';




