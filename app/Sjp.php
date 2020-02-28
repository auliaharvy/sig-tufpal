<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;

class Sjp extends Model
{
    use AutoNumberTrait;
    
   

    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'sjp_id';
    protected $guarded = [];
    protected $table = 'surat_jalan_pallet';

    public function getAutoNumberOptions()
    {
        return [
            'sjp_number' => [
                'format' => function () {
                    return 'SJP-' . date('Ym') . '-?'; // autonumber format. '?' will be replaced with the generated number.
                },
                'length' => 5 // The number of digits in the autonumber
            ]
        ];
    }
}
