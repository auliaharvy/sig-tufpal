<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class SjpPhoto extends Model
{
    /**
     * The table associated with the model.
     * 
     * @var string
     */
    protected $table = 'sjp_photo';

    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $guarded = [];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    
}
