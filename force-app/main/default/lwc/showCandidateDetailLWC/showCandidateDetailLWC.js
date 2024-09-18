import { api, LightningElement, track } from 'lwc';
import getRelatedPositionInfo from '@salesforce/apex/RTA_CandidateController.getRelatedPositionInfo';
import getCandidateById from '@salesforce/apex/RTA_CandidateController.getCandidateById';

export default class ShowCandidateDetailLWC extends LightningElement {
    @api recordId;  
    candidate;
    @track relatedPositions = [];
    candidateDidntApplyForPosition = false;

    connectedCallback() {
        this.loadCandidate();
    }

    async loadCandidate() {
        try {
            console.log('recordId: ', this.recordId);
            this.candidate = await getCandidateById({candidateId: this.recordId});
            console.log('Fetched candidate: ', this.candidate);
        } catch (error) {
            this.candidate = undefined;
            console.error('Cannot retrieve candidate details: ', error);
        }
    }

    handleShowPositionDetails() {
        this.loadPosition();
    }

    async loadPosition() {
        try {
            console.log('recordId: ', this.recordId);
            this.relatedPositions = await getRelatedPositionInfo({candidateId: this.recordId});

            if (this.relatedPositions.length === 0) {
                this.candidateDidntApplyForPosition = true;
            }

            console.log('Fetched positions: ', this.relatedPosition);
        } catch (error) {
            this.relatedPositions = [];
            this.candidateDidntApplyForPosition = true;
            console.error('Cannot retrieve position details: ', error);
        }
    }

}