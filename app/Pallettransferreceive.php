<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Pallettransferreceive extends Model
{
    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'pallet_transfer_receive_pallet_id';
    protected $guarded = [];
    protected $table = 'pallet_transfer_receive_pallet';
}
