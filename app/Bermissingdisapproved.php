<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Bermissingdisapproved extends Model
{
    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'ber_missing_pallet_disapproved_id';
    protected $guarded = [];
    protected $table = 'ber_missing_pallet_disapproved';
}
