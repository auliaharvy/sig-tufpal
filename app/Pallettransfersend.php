<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;


class Pallettransfersend extends Model
{
    use AutoNumberTrait;
    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'pallet_transfer_send_pallet_id';
    protected $guarded = [];
    protected $table = 'pallet_transfer_send_pallet';

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
