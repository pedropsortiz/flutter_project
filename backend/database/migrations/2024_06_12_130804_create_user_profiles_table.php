<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserProfilesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_profiles', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->timestamps();
            $table->tinyInteger('treatment_form')->default(0)->comment('0 - Informal, 1 - Formal');
            $table->tinyInteger('response_style')->default(0)->comment('0 - Concise, 1 - Detailed');
            $table->tinyInteger('elaboration_level')->default(0)->comment('0 - Basic, 1 - Intermediate, 2 - Advanced');
            $table->string('preferred_language')->default('pt-BR');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('user_profiles');
    }
}
