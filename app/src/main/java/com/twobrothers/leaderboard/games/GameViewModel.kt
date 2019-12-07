package com.twobrothers.leaderboard.games

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.firebase.firestore.FirebaseFirestore
import com.twobrothers.leaderboard.core.Event
import com.twobrothers.leaderboard.core.responces.FirebaseGame
import com.twobrothers.leaderboard.games.models.Game

class GameViewModel(sportId: String) {

    private val _games = MutableLiveData<List<Game>>()
    val games: LiveData<List<Game>> = _games

    private val _navigateToGame = MutableLiveData<Event<String>>()
    val navigateToGame: LiveData<Event<String>> = _navigateToGame

    init {
        val db = FirebaseFirestore.getInstance()

        val sportRef = db.collection("sports").document(sportId)

        db.collection("games").whereEqualTo("sport", sportRef).get()
            .addOnSuccessListener {
                _games.value = it.documents.mapNotNull {
                    it.toObject(FirebaseGame::class.java)?.toGameModel(it.id)
                }
            }
    }

    fun onGameClick(id: String) {
        _navigateToGame.value = Event(id)
    }
}