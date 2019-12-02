package com.twobrothers.leaderboard.scores

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.twobrothers.leaderboard.scores.models.ScoreCard

class ScoresViewModel {

    private val _scores = MutableLiveData<List<ScoreCard>>()
    val scores: LiveData<List<ScoreCard>> = _scores

    init {
        // TODO: Get score data
        /* val db = FirebaseFirestore.getInstance()
        db.collection("sports").get().addOnSuccessListener {
            _sports.value = it.documents.mapNotNull {
                it.toObject(FirebaseSport::class.java)?.toSportsModel(it.id)
            }
        }*/
    }
}