<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Driver extends Model
{
    /**
     * The table associated with the model.
     * 
     * @var string
     */
    protected $table = 'driver';

    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'driver_id';

    /**
     * @var array
     */
    protected $guarded = [];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    
}
