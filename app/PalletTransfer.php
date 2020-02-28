<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;

class PalletTransfer extends Model
{
    use AutoNumberTrait;

    protected $primaryKey = 'pallet_transfer_id';
    protected $guarded = [];
    protected $table = 'pallet_transfer';

    public function getAutoNumberOptions()
    {
        return [
            'tp_number' => [
                'format' => function () {
                    return 'TP-' . date('Ym') . '-?'; // autonumber format. '?' will be replaced with the generated number.
                },
                'length' => 5 // The number of digits in the autonumber
            ]
        ];
    }

}
