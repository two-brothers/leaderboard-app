package com.twobrothers.leaderboard.sports

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.twobrothers.leaderboard.R
import com.twobrothers.leaderboard.sports.models.SportsModel


class SportsListAdapter(
    private val onSportClickListener: OnSportClickListener?
) : ListAdapter<SportsModel, SportsListAdapter.SportsListViewHolder>(SportsListDifferConfig()) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): SportsListViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.view_sport_item, parent, false)
        return SportsListViewHolder(view)
    }

    override fun onBindViewHolder(holder: SportsListViewHolder, position: Int) {
        holder.bind(getItem(position))
    }

    inner class SportsListViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        fun bind(sportsModel: SportsModel) {
            itemView.findViewById<TextView>(R.id.text_sport).text = sportsModel.title
            itemView.setOnClickListener {
                onSportClickListener?.onClick(sportsModel.title)
            }
        }
    }

    private class SportsListDifferConfig : DiffUtil.ItemCallback<SportsModel>() {
        override fun areItemsTheSame(oldItem: SportsModel, newItem: SportsModel): Boolean {
            return oldItem.title == newItem.title
        }

        override fun areContentsTheSame(
            oldItem: SportsModel,
            newItem: SportsModel
        ): Boolean {
            return oldItem.title == newItem.title
        }
    }

}

interface OnSportClickListener {
    fun onClick(title: String)
}