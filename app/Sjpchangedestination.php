<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Sjpchangedestination extends Model
{
    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'sjp_change_destination_id';
    protected $guarded = [];
    protected $table = 'sjp_change_destination';
}
