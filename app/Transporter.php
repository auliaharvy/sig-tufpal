<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Transporter extends Model
{
    /**
     * The table associated with the model.
     * 
     * @var string
     */
    protected $table = 'transporter';

    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'transporter_id';

    /**
     * @var array
     */
    protected $guarded = [];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    
}
