<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;

class Bermissing extends Model
{
    use AutoNumberTrait;

    protected $primaryKey = 'ber_missing_pallet_id';
    protected $guarded = [];
    protected $table = 'ber_missing_pallet';

    public function getAutoNumberOptions()
    {
        return [
            'bmp_number' => [
                'format' => function () {
                    return 'BMP-' . date('Ym') . '-?'; // autonumber format. '?' will be replaced with the generated number.
                },
                'length' => 5 // The number of digits in the autonumber
            ]
        ];
    }

}
