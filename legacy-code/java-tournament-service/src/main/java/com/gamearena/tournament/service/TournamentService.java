package com.gamearena.tournament.service;

import com.gamearena.tournament.model.Tournament;
import com.gamearena.tournament.model.TournamentStatus;
import com.gamearena.tournament.repository.TournamentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * Legacy Tournament Service - BLOCKING operations
 * Needs migration to reactive patterns with Mono/Flux
 */
@Service
public class TournamentService {

    @Autowired
    private TournamentRepository repository;

    /**
     * Get all tournaments - BLOCKING
     */
    public List<Tournament> findAll() {
        // Simulate slow database query
        try {
            Thread.sleep(100);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        return repository.findAll();
    }

    /**
     * Get tournament by ID - BLOCKING
     */
    public Tournament findById(Long id) {
        Optional<Tournament> tournament = repository.findById(id);
        return tournament.orElseThrow(() -> 
            new RuntimeException("Tournament not found with id: " + id)
        );
    }

    /**
     * Create tournament - BLOCKING
     */
    @Transactional
    public Tournament save(Tournament tournament) {
        return repository.save(tournament);
    }

    /**
     * Update tournament - BLOCKING
     */
    @Transactional
    public Tournament update(Long id, Tournament tournamentDetails) {
        Tournament tournament = findById(id);
        tournament.setName(tournamentDetails.getName());
        tournament.setGame(tournamentDetails.getGame());
        tournament.setStatus(tournamentDetails.getStatus());
        tournament.setStartDate(tournamentDetails.getStartDate());
        tournament.setEndDate(tournamentDetails.getEndDate());
        tournament.setMaxParticipants(tournamentDetails.getMaxParticipants());
        tournament.setPrizePool(tournamentDetails.getPrizePool());
        return repository.save(tournament);
    }

    /**
     * Delete tournament - BLOCKING
     */
    @Transactional
    public void delete(Long id) {
        Tournament tournament = findById(id);
        repository.delete(tournament);
    }

    /**
     * Get tournaments by status - BLOCKING
     */
    public List<Tournament> findByStatus(TournamentStatus status) {
        return repository.findByStatus(status);
    }

    /**
     * Get tournaments by game - BLOCKING
     */
    public List<Tournament> findByGame(String game) {
        return repository.findByGame(game);
    }
}
