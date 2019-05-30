module.exports = class CustomEvent{
    constructor(_id, userId, title, description, startTime, endTime){
        this._id = _id,
        this.userId = userId,
        this.title = title,
        this.description = description,
        this.startTime = startTime,
        this.endTime = endTime
    }
}
