namespace java dev.vality.bouncer.threats
namespace erlang bouncer.threats
namespace elixir Bouncer.Threats

include "context.thrift"
include "base.thrift"

typedef string SubjectID

struct ThreatContext {
    /**
    * Фрагмент контекста, предназначеный для передачи в Arbiter (context_v1.ContextThreats)
    */
    1: optional context.ContextFragment fragment
}

service ThreatDetector {

    void ProcessEvent (1: base.Event event)

    /**
    * ThreatDetector не содержит базу субъектов, для сервиса это эфемерные сущности
    * поэтому он не может отличить ситуацию "нет субъекта" от "нет активных угроз для субъекта".
    * Если активных угроз по субъекту не обнаружено, то возвращается пустой контекст
    */
    ThreatContext GetContext (1: SubjectID id)

    /**
    * Очищение контекста угроз - это операция, которая
    * отменит активные "сработки" правил обнаружения угроз для субъекта
    * (по сути это операция разблокировки пользователя)
    */
    void ClearContext (1: SubjectID id)
}
