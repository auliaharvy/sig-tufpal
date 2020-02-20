<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PalletTransfer extends Model
{
    protected $primaryKey = 'pallet_transfer_id';
    protected $guarded = [];
    protected $table = 'pallet_transfer';

}
