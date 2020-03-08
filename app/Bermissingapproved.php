<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Bermissingapproved extends Model
{
    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'ber_missing_pallet_approved_id';
    protected $guarded = [];
    protected $table = 'ber_missing_pallet_approved';
}
