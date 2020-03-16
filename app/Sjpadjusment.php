<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;

class Sjpadjusment extends Model
{
    use AutoNumberTrait;
    
    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'sjp_adjusment_id';
    protected $guarded = [];
    protected $table = 'sjp_adjusment';

    public function getAutoNumberOptions()
    {
        return [
            'sa_number' => [
                'format' => function () {
                    return 'SA-' . date('Ym') . '-?'; // autonumber format. '?' will be replaced with the generated number.
                },
                'length' => 5 // The number of digits in the autonumber
            ]
        ];
    }
}
