module.exports = class CustomEvent{
    constructor(mongoId, userId, title, description, startTime, endTime){
        this.mongoId = mongoId,
        this.userId = userId,
        this.title = title,
        this.description = description,
        this.startTime = startTime,
        this.endTime = endTime
    }
}
