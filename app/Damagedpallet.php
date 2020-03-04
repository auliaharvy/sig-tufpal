<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;

class Damagedpallet extends Model
{
    use AutoNumberTrait;

    protected $primaryKey = 'damaged_pallet_id';
    protected $guarded = [];
    protected $table = 'damaged_pallet';

    public function getAutoNumberOptions()
    {
        return [
            'dp_number' => [
                'format' => function () {
                    return 'DP-' . date('Ym') . '-?'; // autonumber format. '?' will be replaced with the generated number.
                },
                'length' => 5 // The number of digits in the autonumber
            ]
        ];
    }

}
