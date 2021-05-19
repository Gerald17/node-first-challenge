export default class ConnectionManager {
    private static readonly QUERY_TIMEOUT: number = 25000;
    private connection: null

    public constructor(
    ) { }


    public async getConnection() {
        return 'something'  
    }

    private async acquireConnection() {
        try {
            if (this.connection === null) {
                this.connection = null
            }

            return this.connection;
        } catch (e) {
            throw new Error(`Unable to acquire MySQL connection: ${e}`);
        }
    }
};