package com.twobrothers.leaderboard.scores.add

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.firebase.firestore.FirebaseFirestore
import com.twobrothers.leaderboard.core.responces.FirebasePlayer
import com.twobrothers.leaderboard.players.models.Player

class AddScoreViewModel {

    val score = MutableLiveData<String>()
    val player = MutableLiveData<Int>()

    private val _players = MutableLiveData<List<Player>>()
    val players: LiveData<List<Player>> = _players

    init {
        val db = FirebaseFirestore.getInstance()
        db.collection("players").get().addOnSuccessListener {
            _players.value = it.documents.mapNotNull {
                it.toObject(FirebasePlayer::class.java)?.toPlayer(it.id)
            }
        }
    }

    fun onSaveScore() {
        println("${player.value} ${score.value}")
    }
}