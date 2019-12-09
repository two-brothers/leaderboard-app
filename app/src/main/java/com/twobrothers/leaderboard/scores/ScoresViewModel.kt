package com.twobrothers.leaderboard.scores

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.firebase.firestore.FirebaseFirestore
import com.twobrothers.leaderboard.core.Event
import com.twobrothers.leaderboard.core.lookups.GameType
import com.twobrothers.leaderboard.core.responces.FirebaseGame
import com.twobrothers.leaderboard.core.responces.FirebasePlayer
import com.twobrothers.leaderboard.games.models.Game
import com.twobrothers.leaderboard.games.models.ScoreCard

class ScoresViewModel(private val gameId: String) {

    private val _title = MutableLiveData<String>()
    val title: LiveData<String> = _title

    private val _scores = MutableLiveData<List<ScoreCard>>()
    val scores: LiveData<List<ScoreCard>> = _scores

    private val _gameType = MutableLiveData<GameType>()
    val gameType: LiveData<GameType> = _gameType

    private val _navigateToCreateScore = MutableLiveData<Event<Unit>>()
    val navigateToCreateScore: LiveData<Event<Unit>> = _navigateToCreateScore

    init {
        getData()
    }

    private fun getData() {
        val db = FirebaseFirestore.getInstance()
        db.document("games/$gameId").addSnapshotListener { snapshot, e ->
            if (e != null || snapshot == null || !snapshot.exists()) {
                return@addSnapshotListener
            }

            val game = snapshot.toObject(FirebaseGame::class.java) ?: return@addSnapshotListener

            _gameType.value = GameType.getById(game.gameType)

            game.leaders.forEachIndexed { index, leader ->
                leader.player?.get()?.addOnSuccessListener {
                    val player = it.toObject(FirebasePlayer::class.java)?.toPlayer()
                        ?: return@addOnSuccessListener
                    val scoreCard = ScoreCard(index, player, leader.score)
                    val scores = _scores.value?.toMutableList() ?: mutableListOf()
                    scores.add(scoreCard)
                    _scores.value = scores.toList().take(10).sortedBy { it.score }
                }
            }

        }
    }

    fun onAddScoreClick() {
        _navigateToCreateScore.value = Event(Unit)
    }
}