<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Sjppalletreceive extends Model
{
    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'sjp_pallet_receive_id';
    protected $guarded = [];
    protected $table = 'sjp_pallet_receive';
}
