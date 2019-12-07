package com.twobrothers.leaderboard.sports

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.firebase.firestore.FirebaseFirestore
import com.twobrothers.leaderboard.core.Event
import com.twobrothers.leaderboard.core.responces.FirebaseSport
import com.twobrothers.leaderboard.sports.models.Sport

class SportsViewModel {

    private val _sports = MutableLiveData<List<Sport>>()
    val sports: LiveData<List<Sport>> = _sports

    private val _navigateToSport = MutableLiveData<Event<String>>()
    val navigateToSport: LiveData<Event<String>> = _navigateToSport

    init {
        val db = FirebaseFirestore.getInstance()
        db.collection("sports").get().addOnSuccessListener {
            _sports.value = it.documents.mapNotNull {
                it.toObject(FirebaseSport::class.java)?.toSportsModel(it.id)
            }
        }
    }

    fun onSportClick(id: String) {
        _navigateToSport.value = Event(id)
    }
}