<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Bermissingreported extends Model
{
    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'ber_missing_pallet_reported_id';
    protected $guarded = [];
    protected $table = 'ber_missing_pallet_reported';
}
