<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class DeletedItem extends Model
{
    /**
     * The primary key for the model.
     *
     * @var string
     */
    protected $primaryKey = 'id';
    protected $guarded = [];
    protected $table = 'deleted_item';

}
