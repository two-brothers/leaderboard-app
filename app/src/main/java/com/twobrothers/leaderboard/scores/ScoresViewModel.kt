package com.twobrothers.leaderboard.scores

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.firebase.firestore.FirebaseFirestore
import com.twobrothers.leaderboard.games.models.FirebaseGame
import com.twobrothers.leaderboard.games.models.ScoreCard

class ScoresViewModel(gameId: String) {

    private val _title = MutableLiveData<String>()
    val title: LiveData<String> = _title

    private val _scores = MutableLiveData<List<ScoreCard>>()
    val scores: LiveData<List<ScoreCard>> = _scores

    init {
        val db = FirebaseFirestore.getInstance()
        db.document("games/$gameId").get().addOnSuccessListener {
            val game = it.toObject(FirebaseGame::class.java)?.toGameModel(it.id)
            if (game != null) {
                _title.value = game.title
                _scores.value = game.scores
            }
        }
    }
}