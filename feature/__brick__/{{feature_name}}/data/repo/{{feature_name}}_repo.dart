

class {{feature_name.pascalCase()}}Repo {


  Future<void> makeARequest()async {

      try {
        // make a call
      }  on TypeError catch (e) {
      throw BadDataException(e.toString(), StackTrace.current);
    } on FormatException catch (e) {
      throw BadDataException(e.toString(), StackTrace.current);
    } on DioError catch (e) {
      throw InternetException(e.message, StackTrace.current);
    } catch (e) {
      throw UnknownException(e.toString(), StackTrace.current);
    }

  }
}