<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;

class Repairedpallet extends Model
{
    use AutoNumberTrait;

    protected $primaryKey = 'repaired_pallet_id';
    protected $guarded = [];
    protected $table = 'repaired_pallet';

    public function getAutoNumberOptions()
    {
        return [
            'rp_number' => [
                'format' => function () {
                    return 'RP-' . date('Ym') . '-?'; // autonumber format. '?' will be replaced with the generated number.
                },
                'length' => 5 // The number of digits in the autonumber
            ]
        ];
    }

}
