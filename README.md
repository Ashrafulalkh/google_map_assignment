## NOTICE FOR API

> This app loads the API key from Android's `local.properties` file so that the Google Map API doesn't get exposed.

1. **Run** `pub get` to generate `local.properties`

    ```sh
    flutter pub get
    ```

2. Go to `android/local.properties`

3. Add this key inside the `local.properties`

    ```sh
    MAPS_API_KEY=addApiKey
    ```
