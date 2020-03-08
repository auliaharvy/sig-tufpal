<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;


class Bermissingreported extends Model
{
    use AutoNumberTrait;
    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'ber_missing_pallet_reported_id';
    protected $guarded = [];
    protected $table = 'ber_missing_pallet_reported';

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
