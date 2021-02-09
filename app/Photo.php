<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Photo extends Model
{
    /**
     * The table associated with the model.
     * 
     * @var string
     */
    protected $table = 'photo';

    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'photo_id';
    protected $guarded = [];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    
}
