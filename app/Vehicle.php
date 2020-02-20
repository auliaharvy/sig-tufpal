<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Vehicle extends Model
{
    /**
     * The table associated with the model.
     * 
     * @var string
     */
    protected $table = 'vehicle';

    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'vehicle_id';

    /**
     * @var array
     */
    protected $guarded = [];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    
}
