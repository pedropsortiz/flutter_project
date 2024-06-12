<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EventSuggestion extends Model
{
    protected $guarded = [];

    protected $table = 'event_suggestions';

    public function event()
    {
        return $this->belongsTo(Event::class);
    }

    public function suggestion()
    {
        return $this->belongsTo(Suggestion::class);
    }
}
