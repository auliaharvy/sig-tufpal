<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Sjpadjusment extends Model
{
    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'sjp_adjusment_id';
    protected $guarded = [];
    protected $table = 'sjp_adjusment';
}
