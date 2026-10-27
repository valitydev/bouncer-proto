namespace java dev.vality.bouncer.threats
namespace erlang bouncer.threats
namespace elixir Bouncer.Threats

include "context.thrift"
include "base.thrift"

typedef map<string, string> Event

typedef string SubjectID

struct ThreatContext {
    /**
    * Максимальныый уровень угрозы, зафиксированный для заданного субъекта
    */
    1: required base.ThreatLevel level
    /**
    * Фрагмент контекста, предназначеный для передачи в Arbiter (context_v1.ContextThreats)
    */
    2: required context.ContextFragment fragment
}

service ThreatDetector {

    void ProcessEvent (1: Event event)

    /**
    * ThreatDetector не содержит базу субъектов, для сервиса это эфемерные сущности
    * поэтому он не может отличить ситуацию "нет субъекта" от "нет активных угроз для субъекта".
    * Если активных угроз по субъекту не обнаружено, то по умолчанию возвращается контекст с level = informational
    */
    ThreatContext GetContext (1: SubjectID id)

    /**
    * Очищение контекста угроз - это операция, которая
    * отменит активные "сработки" правил обнаружения угроз для субъекта
    * (по сути это операция разблокировки пользователя)
    */
    void ClearContext (1: SubjectID id)
}
