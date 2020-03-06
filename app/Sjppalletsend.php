<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Sjppalletsend extends Model
{
    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'sjp_pallet_send_id';
    protected $guarded = [];
    protected $table = 'sjp_pallet_send';
}
